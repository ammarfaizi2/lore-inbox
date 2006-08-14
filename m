Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWHNRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWHNRVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWHNRVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:21:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:54674 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932532AbWHNRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:21:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WrBsZrVI68lJTDZVVhpEjnX+xFBnjYnOGe611un6go/CuPgSeEDUHnTTT72/xKC0I4/w1idjj2p3FaM1CeeXt/jSnzpdd/a8pBk3IVI08hVNAv+5vqTH8x+BhLEIbA20djOhR2B+lUG1J1PKwVIR2OVvL86pEmZaq+HEfCp+4YM=
Message-ID: <62b0912f0608141021k29fe899bhf49a4f82cae2173@mail.gmail.com>
Date: Mon, 14 Aug 2006 19:21:17 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
In-Reply-To: <20060814153459.GA12298@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
	 <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
	 <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
	 <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com>
	 <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com>
	 <20060812163834.GA11497@thunk.org>
	 <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com>
	 <20060812214719.GA19156@thunk.org>
	 <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
	 <20060814153459.GA12298@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> To be fair, there are plenty of other dangerous things that you can do
> with Windows that don't have warning messages pop-up.  And using the
> loop driver is of a complexity which is higher than what you would
> expect of a typical Windows user.  You might as well complain that
> Linux doesn't give a warning message when you run some command like
> "rm -rf /", or "dd if=/dev/null of=/dev/hda".  I'm sure there are
> similar commands (probably involving regedit :-) that are just as
> dangerous from the Windows cmd.exe window.....

Hardly comparable..

"rm", "dd if=/dev/null", "format c:" is meant to nuke your harddrive.
The loop driver just does it as a nasty side effect of a stinky
implementation.
