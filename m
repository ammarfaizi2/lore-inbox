Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136398AbRD2WdY>; Sun, 29 Apr 2001 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136397AbRD2WdO>; Sun, 29 Apr 2001 18:33:14 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:15379 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S136398AbRD2WdA>; Sun, 29 Apr 2001 18:33:00 -0400
Date: Mon, 30 Apr 2001 00:32:49 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic when booting 2.4.4
Message-ID: <20010430003249.A1286@gondor.com>
In-Reply-To: <20010429212545.A2208@gondor.com> <20010429124317.A947@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010429124317.A947@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Apr 29, 2001 at 12:43:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 12:43:17PM -0700, Manuel McLure wrote:
> Does your motherboard have a Promise FastTrak on it? If so this is a bug I
> reported in 2.4.3-ac10/11 and that Alan Cox fixed in -ac12 - for some
> reason it didn't make it into 2.4.4. I was just about to report it myself
> when I saw your mail. The following patch fixes:

Yes, the patch fixed the problem!

