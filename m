Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSIXNP2>; Tue, 24 Sep 2002 09:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSIXNP2>; Tue, 24 Sep 2002 09:15:28 -0400
Received: from holomorphy.com ([66.224.33.161]:41626 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261662AbSIXNP2>;
	Tue, 24 Sep 2002 09:15:28 -0400
Date: Tue, 24 Sep 2002 06:20:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.38-mm2 dbench $N times
Message-ID: <20020924132031.GJ6070@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taken on 32x/32G NUMA-Q:

Throughput 67.3949 MB/sec (NB=84.2436 MB/sec  673.949 MBit/sec)  16 procs
dbench 16  11.72s user 122.21s system 422% cpu 31.733 total

Throughput 95.1519 MB/sec (NB=118.94 MB/sec  951.519 MBit/sec)  32 procs
dbench 32  24.71s user 357.97s system 847% cpu 45.175 total

Throughput 93.8379 MB/sec (NB=117.297 MB/sec  938.379 MBit/sec)  64 procs
dbench 64  56.03s user 773.39s system 903% cpu 1:31.75 total

Throughput 87.2713 MB/sec (NB=109.089 MB/sec  872.713 MBit/sec)  128 procs
dbench 128  116.31s user 1524.85s system 840% cpu 3:15.16 total

Throughput 84.454 MB/sec (NB=105.567 MB/sec  844.54 MBit/sec)  192 procs
dbench 192  180.64s user 2293.04s system 821% cpu 5:01.13 total

Throughput 82.9662 MB/sec (NB=103.708 MB/sec  829.662 MBit/sec)  224 procs
dbench 224  212.30s user 2716.77s system 820% cpu 5:57.15 total

Throughput 37.9382 MB/sec (NB=47.4227 MB/sec  379.382 MBit/sec)  256 procs
dbench 256  237.38s user 3115.41s system 376% cpu 14:51.40 total

Throughput 25.7546 MB/sec (NB=32.1932 MB/sec  257.546 MBit/sec)  512 procs
dbench 512  465.96s user 5980.49s system 245% cpu 43:45.79 total


Cheers,
Bill
