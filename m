Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbUCJTa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbUCJTa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:30:27 -0500
Received: from colino.net ([62.212.100.143]:45301 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262787AbUCJTaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:30:21 -0500
Date: Wed, 10 Mar 2004 20:29:33 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: David Mosberger <davidm@napali.hpl.hp.com>, linux-usb-devel@lists.sf.net
Subject: Re: serious 2.6 bug in USB subsystem?
Message-Id: <20040310202933.4c92e78c@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <16462.48341.393442.583311@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Your patch at 
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107890218325615&w=2

does fix the "OHCI unrecoverable error" and "ep0in control timeout" and the 
other errors I kept getting with my ACM modem (motorola GPRS phone).

Thanks !

(PS I also applied this one:
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107890407025557&w=2 )

-- 
Colin
