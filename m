Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTGJWMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGJWL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:11:27 -0400
Received: from smtp.terra.es ([213.4.129.129]:63643 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S269589AbTGJWLV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:11:21 -0400
Date: Fri, 11 Jul 2003 00:26:07 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: "=?ISO-8859-15?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile warnings
Message-Id: <20030711002607.6b82540f.diegocg@teleline.es>
In-Reply-To: <20030710175135.1c6094d8.rmrmg@wp.pl>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
	<20030710175135.1c6094d8.rmrmg@wp.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 10 Jul 2003 17:51:35 +0200 Rafa³ 'rmrmg' Roszak <rmrmg@wp.pl> escribió:

> Hi
> 
> "Nie ma takiego pliku ani katalogu"  mean " no such file or directory"
> and "UWAGA: 1 z 13 wyliczonych sum kontrolnych siê NIE zgadza"  mean 
> "1of 13 checked  checksums is NOT correct."


could you recompile with "LC_ALL='C' make whatever" ?

