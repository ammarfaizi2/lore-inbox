Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314154AbSD0RZB>; Sat, 27 Apr 2002 13:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSD0RZA>; Sat, 27 Apr 2002 13:25:00 -0400
Received: from ns.suse.de ([213.95.15.193]:32787 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314154AbSD0RY7>;
	Sat, 27 Apr 2002 13:24:59 -0400
Date: Sat, 27 Apr 2002 19:24:59 +0200
From: Dave Jones <davej@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.10-dj1 compilation failure
Message-ID: <20020427192459.P14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Christoph Lameter <christoph@lameter.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204271017510.5443-100000@k2-400.lameter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 10:18:20AM -0700, Christoph Lameter wrote:
 > ide-scsi.c:837: unknown field `abort' specified in initializer
 > ide-scsi.c:837: warning: initialization from incompatible pointer type
 > ide-scsi.c:838: unknown field `reset' specified in initializer
 > ide-scsi.c:838: warning: initialization from incompatible pointer type

http://lwn.net/daily/2.5.10-dj1-scsi.php3

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
