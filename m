Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTC1Hh4>; Fri, 28 Mar 2003 02:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTC1Hh4>; Fri, 28 Mar 2003 02:37:56 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:63739
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262258AbTC1Hhz>; Fri, 28 Mar 2003 02:37:55 -0500
Date: Fri, 28 Mar 2003 02:45:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
In-Reply-To: <20030328040038.GO1350@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303280243080.2884-100000@montezuma.mastecende.com>
References: <20030328040038.GO1350@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

before:
Memory: 65306956k/67100672k available (1724k kernel code, 98252k reserved, 781k data, 284k init, 65134592k highmem)
after:
Memory: 65946144k/67100672k available (1956k kernel code, 15936k reserved, 667k data, 300k init, 65198080k highmem)

Would you mind explaining the details as to what would cause that 
discrepancy in reserved memory size?

	Zwane
-- 
function.linuxpower.ca
