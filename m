Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTK2Qel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTK2Qel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:34:41 -0500
Received: from ppp-62-245-235-62.mnet-online.de ([62.245.235.62]:48513 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263800AbTK2Qej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:34:39 -0500
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <200311292325.44935.csawtell@paradise.net.nz>
	<1070104685.29442.24.camel@athlonxp.bradney.info>
From: Julien Oster <frodoid@frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sat, 29 Nov 2003 17:34:37 +0100
In-Reply-To: <1070104685.29442.24.camel@athlonxp.bradney.info> (Craig
 Bradney's message of "Sat, 29 Nov 2003 12:18:05 +0100")
Message-ID: <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney <cbradney@zip.com.au> writes:

Hello Craig,

> I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
> I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
> turned on (SMP off, Preemptible Kernel off).

Unfortunately, I have the exact same configuration, with massive
lockups. Could you try executing "hdparm -t /dev/<someharddisk>"
several times and see if it lockups?

Regards,
Julien
