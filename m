Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSCEVE6>; Tue, 5 Mar 2002 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293725AbSCEVEs>; Tue, 5 Mar 2002 16:04:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38408 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S310214AbSCEVE2>; Tue, 5 Mar 2002 16:04:28 -0500
Date: Tue, 5 Mar 2002 18:04:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Pavel Machek <pavel@suse.cz>
Cc: Rakesh Kumar Banka <Rakesh@asu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Monolithic Vs. Microkernel
In-Reply-To: <20020304144923.A96@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0203051803120.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Pavel Machek wrote:

> > This means we can have all the advantages of modularity at the
>
> Not *all* of them. On vsta, you could do
>
> ( killall keyboard; sleep 1; keyboard ) &

How is that different from the following ?

(rmmod keyboard ; sleep 1 ; modprobe keyboard)

[no, no need to talk about hardware access ... vsta's keyboard
driver also has hardware access]

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

