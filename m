Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313613AbSDFPVP>; Sat, 6 Apr 2002 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313614AbSDFPVO>; Sat, 6 Apr 2002 10:21:14 -0500
Received: from [194.46.8.33] ([194.46.8.33]:4869 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S313613AbSDFPVM>;
	Sat, 6 Apr 2002 10:21:12 -0500
Date: Sat, 6 Apr 2002 16:34:29 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Re: make install bug?
Message-ID: <20020406153429.GL17144@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020406151531.GK17144@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 04:15:31PM +0100, Dale Amon wrote:
> I'm not sure why this started happening, but it isn't nice
> behavior at all. I'd call it a bug as I can't imagine why
> I'd want a depmod to occur on the build machine.

Hmmm, I think I failed to engage brain before fingers. Sent
the files to a non-existant directory... which might be
the thing that tickled it to do the depmod?

