Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278239AbRJSAqU>; Thu, 18 Oct 2001 20:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275798AbRJSAqJ>; Thu, 18 Oct 2001 20:46:09 -0400
Received: from otter.mbay.net ([206.40.79.2]:18956 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S275756AbRJSApy> convert rfc822-to-8bit;
	Thu, 18 Oct 2001 20:45:54 -0400
From: John Alvord <jalvo@mbay.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Date: Thu, 18 Oct 2001 17:46:18 -0700
Message-ID: <9ttustkpmhc24c6q53bv5jghl3g257htdp@4ax.com>
In-Reply-To: <20011018180705.B13661@lug-owl.de> <Pine.LNX.4.40.0110181536290.8316-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0110181536290.8316-100000@dlang.diginsite.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 15:38:36 -0700 (PDT), David Lang
<david.lang@digitalinsight.com> wrote:

>so what will the export_symbol_gpl stuff do with the BSD license? it may
>or may not have source avilable so is it allowed to use the exported
>symbols or not?
>
>for the tainting module process there is the same problem.
>
>knowing the license the code was released under does not tell you if the
>source is available or not.
Linus said that all existing entry points would remain untagged. Thus
existing modules would not be affected.

john
