Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSE3ADj>; Wed, 29 May 2002 20:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSE3ADi>; Wed, 29 May 2002 20:03:38 -0400
Received: from holomorphy.com ([66.224.33.161]:18580 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316199AbSE3ADh>;
	Wed, 29 May 2002 20:03:37 -0400
Date: Wed, 29 May 2002 17:03:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>, frank.schafer@setuza.cz,
        linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <20020530000311.GY14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, frank.schafer@setuza.cz,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu> <20020519.214053.19164382.davem@redhat.com> <1021876190.250.7.camel@ADMIN> <20020520.141800.52934272.davem@redhat.com> <20020529235116.GB3797@branoic.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 02:18:00PM -0700, David S. Miller wrote:
>> I can't see any reason why lack of PTRACE_READDATA prevents follow
>> fork mode support in GDB.

On Wed, May 29, 2002 at 07:51:16PM -0400, Daniel Jacobowitz wrote:
> It doesn't.  Follow-fork support is possible now, with a speed hit, but
> I am waiting for better kernel support; it should be forthcoming with
> the task ornament-based debugging interface proposed some time ago.

What is this and who is working on it?


Cheers,
Bill
