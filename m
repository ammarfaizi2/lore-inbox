Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293222AbSCAK1Y>; Fri, 1 Mar 2002 05:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310429AbSCAKZf>; Fri, 1 Mar 2002 05:25:35 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46354 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S310391AbSCAKXp>; Fri, 1 Mar 2002 05:23:45 -0500
Date: Fri, 1 Mar 2002 06:11:13 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SOLVED Re: rsync kills 2.4.1X, also -ac and 2.4.18-rc4+XFS.
Message-ID: <20020301051113.GA4206@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020301043615.GA1668@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020301043615.GA1668@merlin.emma.line.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2002, Matthias Andree wrote:

> I have some tough stuff to debug for VM hackers.

Actually, that's stuff for rsync hackers, none of kernel stuff. When I
tried all that stuff on a virtual console, the console was quick enough
to let me spot another undead rsync process eating up memory, so it's
not a kernel issue, I believe.

Shame on me I didn't see this before sending me previous mail. Please
apologize.
