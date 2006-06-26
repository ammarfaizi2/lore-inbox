Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWFZRoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFZRoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFZRoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:44:14 -0400
Received: from web52905.mail.yahoo.com ([206.190.49.15]:40366 "HELO
	web52905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751229AbWFZRoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:44:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=phOs8CyKogMyDhTbDLkMzgor2m2CQ/7e+fTrm3EvFXgw+DieSuo0BtHgittUN2fKNSNDjWtfzykYk5fx5wM9gJhnjsc1u80OYhiAqKPTL+Ev0oSyijzLAOlSF5jYlw+7W/DdyevtJRYOOL9GVi4sC4pe+J3R5HUV+HO9I3LQipA=  ;
Message-ID: <20060626174412.76248.qmail@web52905.mail.yahoo.com>
Date: Mon, 26 Jun 2006 18:44:12 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux-2.6.17: PMTimer results for another PCI chipset
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <20060626120847.GA6272@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> Yeah, but this is no problem anyway, since it's neither in the blacklisted
> nor in the graylisted area, IOW it's whitelisted and should work
> without delays.
> Or do you get the "The chipset may have PM-Timer Bug" message here??
> 
> > 00:1f.0 Class 0601: 8086:2440 (rev 05)
> 
> #define PCI_DEVICE_ID_INTEL_82801BA_0   0x2440

Nope, it's all good. But since this chipset was released between the one which definitely has the
bug and one which might have the bug, I thought that it was worth testing it for real.

Cheers,
Chris



		
___________________________________________________________ 
Try the all-new Yahoo! Mail. "The New Version is radically easier to use" – The Wall Street Journal 
http://uk.docs.yahoo.com/nowyoucan.html
