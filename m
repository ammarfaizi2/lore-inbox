Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSEYXWT>; Sat, 25 May 2002 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEYXWS>; Sat, 25 May 2002 19:22:18 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44810 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315449AbSEYXWQ>; Sat, 25 May 2002 19:22:16 -0400
Date: Sun, 26 May 2002 01:22:14 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8 ide bugs
Message-ID: <20020525232214.GD19125@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <004101c20334$361b0b80$baefb0d4@nick> <Pine.LNX.4.10.10205242159110.31297-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Andre Hedrick wrote:

> Obviously you have not enable taskfile IO, if you have then you have my
> attention.  You are running the legacy code which the talented king
> pengiun screwed, and now is return back into 2.5.

How stable is the Taskfile stuff in 2.4.19-pre8-ac5? Good enough for
systems that are in daily use but not production critical? Or will it
eat file systems big time?
