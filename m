Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269850AbRHDSgZ>; Sat, 4 Aug 2001 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269851AbRHDSgP>; Sat, 4 Aug 2001 14:36:15 -0400
Received: from weta.f00f.org ([203.167.249.89]:23184 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269850AbRHDSgH>;
	Sat, 4 Aug 2001 14:36:07 -0400
Date: Sun, 5 Aug 2001 06:36:57 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ivan Kalvatchev <iive@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: DoS with tmpfs #3
Message-ID: <20010805063657.C20164@weta.f00f.org>
In-Reply-To: <20010803163409.62191.qmail@web13609.mail.yahoo.com> <Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 03:07:31AM -0300, Rik van Riel wrote:

    1) you create a tmpfs with a high limit, such that
       (max size tmpfs) + (user memory) > ram + swap

maybe, by default, tmpfs should choose a limit of 1/2 ram available or
something?  if this is too small, people can change it



  --cw
