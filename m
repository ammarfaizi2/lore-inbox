Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTJNJM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJNJM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:12:56 -0400
Received: from [213.229.38.66] ([213.229.38.66]:972 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S262303AbTJNJMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:12:55 -0400
Message-ID: <3F8BBCF7.5020006@winischhofer.net>
Date: Tue, 14 Oct 2003 11:08:07 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
 > On Tue, Oct 14, Arjan van de Ven wrote:
 >
 > > ugh
 >
 > My argument is that this shouldnt be done the usual opensource way
 > 'someone else will fix my shit'. Instead, the driver authors should
 > notice their mistakes right away.

I will certainly not maintain the ancient driver in current 2.6 vanilla. 
This is a framebuffer driver and like all fbdev-related stuff it is 
properly maintained in the fbdev-tree, waiting to merged into mainline.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org




