Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRDBO2H>; Mon, 2 Apr 2001 10:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRDBO15>; Mon, 2 Apr 2001 10:27:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13572 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129443AbRDBO1n>; Mon, 2 Apr 2001 10:27:43 -0400
Date: Mon, 2 Apr 2001 11:25:47 -0300
From: Gustavo Niemeyer <niemeyer@conectiva.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
Message-ID: <20010402112547.C15554@tux.distro.conectiva>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01033016225700.00409@dennis> <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de> <20010402095425.A15554@tux.distro.conectiva> <20010402090025.X1169@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010402090025.X1169@devserv.devel.redhat.com>; from jakub@redhat.com on Mon, Apr 02, 2001 at 09:00:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub!!

[...]
> By any chance, are you dlopening a DSO linked against -lpthread from
> program not linked against -lpthread?

Yes, I am!! Is this some limitation I'm not aware of?

Indeed, this seems to be made in many cases... is this about pthread??

-- 
Gustavo Niemeyer

[ 2AAC 7928 0FBF 0299 5EB5  60E2 2253 B29A 6664 3A0C ]
