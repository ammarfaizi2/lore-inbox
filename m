Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314292AbSD0Rf7>; Sat, 27 Apr 2002 13:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSD0Rf6>; Sat, 27 Apr 2002 13:35:58 -0400
Received: from adsl-64-171-6-36.dsl.sntc01.pacbell.net ([64.171.6.36]:6911
	"EHLO k2-400.lameter.com") by vger.kernel.org with ESMTP
	id <S314292AbSD0Rf5>; Sat, 27 Apr 2002 13:35:57 -0400
Date: Sat, 27 Apr 2002 10:35:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.10-dj1 compilation failure
In-Reply-To: <20020427192459.P14743@suse.de>
Message-ID: <Pine.LNX.4.44.0204271033010.5612-100000@k2-400.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That stuff might be useful in a CVS or BK() source code archive.
What is the purpose of releasing a kernel tarball that does not compile?
Kernel tarball are there to be compiled and tried out ....

On Sat, 27 Apr 2002, Dave Jones wrote:

> On Sat, Apr 27, 2002 at 10:18:20AM -0700, Christoph Lameter wrote:
>  > ide-scsi.c:837: unknown field `abort' specified in initializer
>  > ide-scsi.c:837: warning: initialization from incompatible pointer type
>  > ide-scsi.c:838: unknown field `reset' specified in initializer
>  > ide-scsi.c:838: warning: initialization from incompatible pointer type
>
> http://lwn.net/daily/2.5.10-dj1-scsi.php3

