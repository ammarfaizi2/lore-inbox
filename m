Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVCWQns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVCWQns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVCWQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:43:48 -0500
Received: from ns5.landhost.net ([69.93.167.98]:39338 "EHLO s5.landhost.net")
	by vger.kernel.org with ESMTP id S261690AbVCWQkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:40:11 -0500
From: Pietro Zuco <maillist@zuco.org>
Reply-To: maillist@zuco.org
Organization: www.zuco.org
To: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
Date: Wed, 23 Mar 2005 17:40:09 +0100
User-Agent: KMail/1.7.1
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231740.09572.maillist@zuco.org>
X-PopBeforeSMTPSenders: adriana@zuco.org,maillist@zuco.org,pietro@zuco.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s5.landhost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zuco.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 16:59, Jesper Juhl wrote:
> On Tue, 22 Mar 2005, Jan Engelhardt wrote:
> > I have observed that squashfs, when mounted, does not return any "." or
> > ".." pseudo-directories upon readdir.
> > Could this be added? Would there be any objections?
>
> I can't say if there will be any objections or not, but if that's
> something that people want

I agree with Jan.
The . / .. will be useful for some scripts that use it.

-Pietro-

-- 
-------------------------------------------
- Pietro Zuco
- Email: pietro@zuco.org
- Email: pietro@member.fsf.org
- Web: http://www.zuco.org
- Join FSF as an Associate Member at:
- http://member.fsf.org/join?referrer=3082>
-
- Linux User Number: #252836
- Get counted! http://counter.li.org
------------------------------------------- 
