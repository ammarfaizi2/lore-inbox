Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSAHLWu>; Tue, 8 Jan 2002 06:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSAHLWk>; Tue, 8 Jan 2002 06:22:40 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:12044 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287244AbSAHLWa>; Tue, 8 Jan 2002 06:22:30 -0500
Date: Tue, 8 Jan 2002 12:22:25 +0100
From: jtv <jtv@xs4all.nl>
To: Anthony DeRobertis <asd@suespammers.org>
Cc: Jacques Gelinas <jack@solucorp.qc.ca>, linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
Message-ID: <20020108122225.B11855@xs4all.nl>
In-Reply-To: <20020107224525.8a899969dbcd@remtk.solucorp.qc.ca> <BD98BECA-0407-11D6-804A-00039355CFA6@suespammers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BD98BECA-0407-11D6-804A-00039355CFA6@suespammers.org>; from asd@suespammers.org on Tue, Jan 08, 2002 at 02:17:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 02:17:14AM -0500, Anthony DeRobertis wrote:
> 
> A nice thing about two stacks is that it can be a completely 
> userspace thing. No need to involve the kernel at all; just gcc 
> and friends.

Doesn't it have ABI implications as well?

If so, why not go all the way and have stacks grow upwards?  :-)


Jeroen

