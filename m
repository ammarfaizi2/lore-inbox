Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTHWR6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbTHWRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:53:14 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:22285 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264916AbTHWRu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:50:28 -0400
Date: Sat, 23 Aug 2003 18:50:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030823185022.A32664@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>, Pavel Machek <pavel@suse.cz>,
	davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>,
	paul.devriendt@amd.com, aj@suse.de
References: <20030822135946.GA2194@elf.ucw.cz> <20030822155207.A17469@infradead.org> <20030822195427.GB2306@elf.ucw.cz> <20030823095521.B14519@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030823095521.B14519@bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sat, Aug 23, 2003 at 09:55:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 09:55:21AM +0200, Rogier Wolff wrote:
> Guys, good programming practise would leave this in. If you want,
> you could add a comment that in the current code, this is superfluous. 

People tend to have different options on good programming practive.
In the linux kenrel world at least these idiom is usually avoided.

