Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293581AbSBZLqI>; Tue, 26 Feb 2002 06:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293583AbSBZLp6>; Tue, 26 Feb 2002 06:45:58 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:44552 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293581AbSBZLpq>;
	Tue, 26 Feb 2002 06:45:46 -0500
Date: Tue, 26 Feb 2002 08:45:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Rakesh Kumar Banka <Rakesh@asu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Monolithic Vs. Microkernel
In-Reply-To: <Pine.GSO.4.21.0202252301510.24728-100000@general3.asu.edu>
Message-ID: <Pine.LNX.4.33L.0202260844260.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Rakesh Kumar Banka wrote:

> Anyone working on the Microkernel implementation
> of Linux? Specially in the area of seperating the process
> and the file management activities out of the kernel.

You have to remember that the source code for Linux is available.

This means we can have all the advantages of modularity at the
source level without needing any of the potential disadvantages
of modularity at the binary level.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

