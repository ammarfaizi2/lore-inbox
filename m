Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHJKrS>; Sat, 10 Aug 2002 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHJKrS>; Sat, 10 Aug 2002 06:47:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:48141 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316792AbSHJKrS>; Sat, 10 Aug 2002 06:47:18 -0400
Date: Sat, 10 Aug 2002 11:51:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
Message-ID: <20020810115100.A5857@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org> <20020810114003.A5459@infradead.org> <3D54EF69.5060709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D54EF69.5060709@zytor.com>; from hpa@zytor.com on Sat, Aug 10, 2002 at 03:48:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 03:48:09AM -0700, H. Peter Anvin wrote:
> Sure, but that still means the *current* ABI is consistent between 
> platforms.

yes, that's why I like the way they do it.  It doesn't really impose any
overhead and is much, much cleaner.

