Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280691AbRKBNoW>; Fri, 2 Nov 2001 08:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280692AbRKBNoN>; Fri, 2 Nov 2001 08:44:13 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:772 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S280691AbRKBNoB>; Fri, 2 Nov 2001 08:44:01 -0500
Date: Fri, 2 Nov 2001 16:43:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christian Groessler <cpg@aladdin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alphastation stopped booting with 2.4.10+
Message-ID: <20011102164319.A628@jurassic.park.msu.ru>
In-Reply-To: <87wv1a5c39.fsf@gibbon.cnet.aladdin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87wv1a5c39.fsf@gibbon.cnet.aladdin.de>; from cpg@aladdin.de on Fri, Nov 02, 2001 at 12:02:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 12:02:34AM +0100, Christian Groessler wrote:
> 2.4.9 worked fine, but starting with 2.4.10 my Alphastation 200
> stopped booting. It simply halts immediately after being called by
> aboot:

Are you sure you have CONFIG_MATHEMU=y (not =m)?

Ivan.
