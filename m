Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSEVHhS>; Wed, 22 May 2002 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSEVHhR>; Wed, 22 May 2002 03:37:17 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59396 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316882AbSEVHhR>; Wed, 22 May 2002 03:37:17 -0400
Message-ID: <3CEB4A6B.A98FC6F4@aitel.hist.no>
Date: Wed, 22 May 2002 09:36:11 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.12-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
In-Reply-To: <86256BC0.0067E23B.00@smtpnotes.altec.com> <20020521.143011.30682853.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
[...]
>    Under 2.5.17 there is a problem with gtop 1.0.9.
> 
> The /proc/meminfo output changed, and this makes a lot of programs
> reading that file explode.

No problem with file format breakage, but the programs 
"exploding" shouldn't get stuck unkillable by kill -9.
looks like a kernel problem to me.

Helge Hafting
