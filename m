Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUBRF7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUBRF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:59:22 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13455
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263711AbUBRF7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:59:21 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Marc Lehmann <pcg@schmorp.de>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Tue, 17 Feb 2004 20:49:38 -0600
User-Agent: KMail/1.5.4
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202043.GD17015@schmorp.de>
In-Reply-To: <20040216202043.GD17015@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402172049.38887.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 14:20, Marc Lehmann wrote:
> On Mon, Feb 16, 2004 at 11:48:35AM -0800, Linus Torvalds <torvalds@osdl.org> 
wrote:
> > works on the raw byte sequence and isn't confused). Basically accept the
> > fact that UTF-8 strings can contain "garbage", and don't try to fix it
> > up.
>
> But you are wrong, UTF-8 strings never contain garbage. UTF-8 is
> well-defined and is always proper UTF-8. It's a tautology.

Would you please learn the difference between "you are wrong" and "I 
disagree"?

Rob


