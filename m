Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSJ0SNR>; Sun, 27 Oct 2002 13:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSJ0SNR>; Sun, 27 Oct 2002 13:13:17 -0500
Received: from chardonnay.math.bme.hu ([152.66.83.144]:40640 "HELO
	chardonnay.math.bme.hu") by vger.kernel.org with SMTP
	id <S261847AbSJ0SNR>; Sun, 27 Oct 2002 13:13:17 -0500
Date: Sun, 27 Oct 2002 19:19:33 +0100
From: KORN Andras <korn-linuxkernel@chardonnay.math.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: [solved] 2.4 very slow memory access on abit kd7raid (kt400); ten times slower than on kg7raid
Message-ID: <20021027181932.GS27554@nilus-2690.adsl.datanet.hu>
Reply-To: korn-linuxkernel@chardonnay.math.bme.hu
Mail-Followup-To: korn-linuxkernel@chardonnay.math.bme.hu
References: <20021027032811.GM27554@nilus-2690.adsl.datanet.hu> <Pine.LNX.4.44.0210271245430.3202-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210271245430.3202-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 12:46:05PM -0500, John Clemens wrote:

Hi,

> Try booting with "acpi=off"

OK, this worked. The system is running at normal speed now.

What was the problem? What did this have to do with acpi?

Andrew

-- 
          Andrew Korn (Korn Andras) <korn at chardonnay.math.bme.hu>
           Finger korn at chardonnay.math.bme.hu for pgp key. QOTD:
            Never let any mechanical device know you're in a hurry.
