Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSAUM3S>; Mon, 21 Jan 2002 07:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSAUM3I>; Mon, 21 Jan 2002 07:29:08 -0500
Received: from ns.suse.de ([213.95.15.193]:57359 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285352AbSAUM3B>;
	Mon, 21 Jan 2002 07:29:01 -0500
Date: Mon, 21 Jan 2002 13:28:58 +0100
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Boot hang in 2.5.3-pre2
Message-ID: <20020121132858.C2729@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Richard Gooch <rgooch@ras.ucalgary.ca>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201210626.g0L6Qg621934@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201210626.g0L6Qg621934@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Jan 20, 2002 at 11:26:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 11:26:42PM -0700, Richard Gooch wrote:
 >   Hi, Linus. FYI: 2.5.3-pre2 hangs during boot. The last couple of
 > messages I get are:
 > Based upon Swansea University Computer Society NET3.039
 > apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
 > apm: disabled - APM is not SMP safe (power off active).

 Ingo's scheduler patches solved this one for me (and others).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
