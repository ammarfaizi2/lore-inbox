Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbSISRAd>; Thu, 19 Sep 2002 13:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbSISRAd>; Thu, 19 Sep 2002 13:00:33 -0400
Received: from mout2.freenet.de ([194.97.50.155]:50584 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id <S271691AbSISRAc>;
	Thu, 19 Sep 2002 13:00:32 -0400
Date: Thu, 19 Sep 2002 19:05:42 +0200
From: axel@hh59.org
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.36-mm1
Message-ID: <20020919170542.GA546@prester.hh59.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <20020919150959.GA1887@prester.hh59.org> <Pine.LNX.4.44L.0209191212580.1519-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209191212580.1519-100000@duckman.distro.conectiva>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik!

On Thu, 19 Sep 2002, Rik van Riel wrote:

> > Segmentation fault
> > Exit 139
> 
> You made sure to run it with the _new_ libproc and not with
> the old one you still have in /lib ?


Yes. I removed my old libproc package that came with my slack 8.1 and built
your procps from CVS.

Regards,
Axel
