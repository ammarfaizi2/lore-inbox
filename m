Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSJGIGb>; Mon, 7 Oct 2002 04:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbSJGIGb>; Mon, 7 Oct 2002 04:06:31 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:51075 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S262914AbSJGIG2> convert rfc822-to-8bit;
	Mon, 7 Oct 2002 04:06:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Hacksaw <hacksaw@hacksaw.org>
Subject: Re: LILO probs
Date: Mon, 7 Oct 2002 10:12:12 +0200
User-Agent: KMail/1.4.1
References: <200210070802.g9782vON007305@habitrail.home.fools-errant.com>
In-Reply-To: <200210070802.g9782vON007305@habitrail.home.fools-errant.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210071012.12712.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 10:02, Hacksaw wrote:
> That partition table does not look normal to me. What was it produced with?

linux fdisk ... or ... no - it was the redhat installation. point is - the 
disk was first installed in an old P90 whose BIOS found the disk as a 
1024/16/63 (504 meg) disk, but linux overrode that, allowing me to use the 
whole disk. I settled with boot from floppy, but I can't use that now.

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

