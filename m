Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTD3MrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTD3MrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:47:09 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:43159 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262157AbTD3MrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:47:07 -0400
Date: Wed, 30 Apr 2003 14:59:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: rmoser <mlmoser@comcast.net>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
Message-ID: <20030430125913.GA21016@wohnheim.fh-wedel.de>
References: <200304292114.h3TLEHBu003733@81-2-122-30.bradfords.org.uk> <200304292059150060.002E747A@smtp.comcast.net> <200304301248.07777.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304301248.07777.kernel@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 April 2003 12:48:07 +1000, Con Kolivas wrote:
> 
> I don't think a parallel project is a bad idea either. I was just suggesting 
> adding the minilzo algorithm from the linuxcompressed project as one of the 
> compression algorithms available.

Actually, I'd like a central compression library with a large
assortment of algorithms. That way the really common code is shared
between both (or more) projects is shared.

Also, yet another unused compression algorithm hurts about as bad, as
yet another unused device driver. It just grows the kernel .tar.bz2.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
