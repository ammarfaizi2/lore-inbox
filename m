Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSGQRoc>; Wed, 17 Jul 2002 13:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGQRoc>; Wed, 17 Jul 2002 13:44:32 -0400
Received: from holomorphy.com ([66.224.33.161]:28551 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315971AbSGQRob>;
	Wed, 17 Jul 2002 13:44:31 -0400
Date: Wed, 17 Jul 2002 10:47:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: shreenivasa H V <shreenihv@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
Message-ID: <20020717174716.GI1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, shreenivasa H V <shreenihv@usa.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain> <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 07:40:19PM +0200, Ingo Molnar wrote:
> you are right in that the Linux scheduler does not enable classic
> gang-scheduling: where multiple processes are scheduled 'at once' on
> multiple CPUs. Can you point out specific (real-life) workloads where this
> would be advantegous? Some testcode would be the best form of expressing
> this. Pretty much any job that uses sane (kernel-based or kernel-helped)
> synchronization should see good throughput.

I will not advocate it myself. I only remembered the definition.


Cheers,
Bill
