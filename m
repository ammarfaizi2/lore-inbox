Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTACGLs>; Fri, 3 Jan 2003 01:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbTACGLs>; Fri, 3 Jan 2003 01:11:48 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:1801 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267414AbTACGLr>; Fri, 3 Jan 2003 01:11:47 -0500
Date: Fri, 3 Jan 2003 01:15:29 -0500
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: andreas.bombe@munich.netsurf.de, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] convert pcilynx.c to C99 initializers
Message-ID: <20030103061529.GL10180@hopper.phunnypharm.org>
References: <20030103061052.GY6114@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103061052.GY6114@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 07:10:52AM +0100, Adrian Bunk wrote:
> Hi Andreas,
> 
> in 2.5.54 struct i2c_adapter changed resulting in a compile error in
> pcilynx.c. The patch below that converts pcilynx.c to C99 initializers 
> fixes it.

Applied to the SVN repo. Linus should get this over the weekend when I
sync with him.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
