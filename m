Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282203AbRK1Xtx>; Wed, 28 Nov 2001 18:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282192AbRK1XtF>; Wed, 28 Nov 2001 18:49:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:47882 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282199AbRK1XtA>;
	Wed, 28 Nov 2001 18:49:00 -0500
Subject: Re: Coding style - a non-issue
From: Robert Love <rml@tech9.net>
To: Peter Waltenberg <pwalten@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 18:48:59 -0500
Message-Id: <1006991340.813.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 18:29, Peter Waltenberg wrote:

> Someone who cares, come up with an indentrc for the kernel code, and get it
> into Documentation/CodingStyle
> If the maintainers run all new code through indent with that indentrc
> before checkin, the problem goes away.
> The only one who'll incur any pain then is a code submitter who didn't
> follow the rules. (Exactly the person we want to be in pain ;)).

See scripts/lindent in your source tree ... does just this.

	Robert Love

