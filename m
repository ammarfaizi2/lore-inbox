Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317813AbSFSIWV>; Wed, 19 Jun 2002 04:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSFSIWU>; Wed, 19 Jun 2002 04:22:20 -0400
Received: from draco.netpower.no ([212.33.133.34]:54283 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317813AbSFSIWU>; Wed, 19 Jun 2002 04:22:20 -0400
Date: Wed, 19 Jun 2002 10:22:12 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Joseph Pingenot <trelane@digitasaru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build problem in sched.c in 2.5.23
Message-ID: <20020619102212.A1827@innova.no>
References: <20020619031247.B5211@ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020619031247.B5211@ksu.edu>; from trelane@digitasaru.net on Wed, Jun 19, 2002 at 03:12:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 03:12:48AM -0500, Joseph Pingenot wrote:
> sched.c:1391: `cpu_online_map' undeclared (first use in this function)
> 
> Need any more details?

Linus posted a patch for this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102446529018948&w=2
