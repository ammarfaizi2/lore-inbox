Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTLSMOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLSMOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:14:52 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:52353 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S262782AbTLSMOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:14:51 -0500
Date: Fri, 19 Dec 2003 13:14:46 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Brian Walker <walkerbm@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: auto load modules
Message-ID: <20031219121446.GA10741@finwe.eu.org>
Mail-Followup-To: Brian Walker <walkerbm@charter.net>,
	linux-kernel@vger.kernel.org
References: <3FE276FA.2030509@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FE276FA.2030509@charter.net>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jak podaj± anonimowe ¼ród³a, przepowiedziano, ¿e Brian Walker napisze:

> Hello. I've just upgraded to 2.6.0 from 2.6.0-test6. When I boot my 
> system, modules that used to load automatically like those for my 
> soundcard,bttv, and serial ports(aka /dev/ttyS*) are no longer loading. 
> I've gone as far as upgrading to module-init-tools-0.9.15-pre4 but 
> nothing makes these modules load automatically anymore. Any ideas?

as for /dev/ttyS* you will need patch, see: 

http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0012.html

bye

-- 
Jacek Kawa
