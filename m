Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUFLCjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUFLCjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUFLCjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:39:25 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:29357 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264543AbUFLCjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:39:19 -0400
X-OB-Received: from unknown (205.158.62.133)
  by wfilter.us4.outblaze.com; 12 Jun 2004 02:38:33 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Pokey the Penguin" <pokey@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: "Andrew Rodland" <arodland@entermail.net>
Date: Sat, 12 Jun 2004 10:39:28 +0800
Subject: Re: [ANNOUNCE] -ar patchset
X-Originating-Ip: 82.35.17.124
X-Originating-Server: ws5-3.us4.outblaze.com
Message-Id: <20040612023928.A103F23C03@ws5-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> find the initial version of the patch, with staircase, 
> autoregulate-swappiness, supermount-ng, ext3 and reiser improvements, and a 

I gather that supermount-ng is now quite dated and no longer maintained. Is 
submount (http://submount.sourceforge.net/) not the current favourite to 
provide such functionality?

Looking at the two, submount definitely seems more ready for inclusion based 
on its non-invasive approach.
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
