Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSG1Kn4>; Sun, 28 Jul 2002 06:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSG1Kn4>; Sun, 28 Jul 2002 06:43:56 -0400
Received: from vitelus.com ([64.81.243.207]:5892 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S315607AbSG1Kn4>;
	Sun, 28 Jul 2002 06:43:56 -0400
Date: Sun, 28 Jul 2002 03:47:10 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
Message-ID: <20020728104710.GA27131@vitelus.com>
References: <3D3761A9.23960.8EB1A2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3761A9.23960.8EB1A2@localhost>
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 12:47:37AM -0400, Guillaume Boissiere wrote:
> o Remove all hardwired drivers from kernel

Ugggggggggggh.

I'm not looking forward to having my kernel split into hundreds of
files, and the overhead of the kernel having to individually load
every driver that's essential to system operation.
