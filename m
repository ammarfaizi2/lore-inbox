Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWILJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWILJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWILJKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:10:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:21046 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965154AbWILJKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:10:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=grDN3qTCWAHY8C/YVvgiLzCFQBthjg94cz4pAjpr7znNhr5roYO2y9ZW8W1ArNlAdPvmGknRZ0M1RCTUws81oGqu8LWED7gSFNdpMZQkQovuEx7hJar+b6pQFnCQEOqRPhSE8MNnHeniW+KHk4jkTGNrNDkEChbY0wA8xSNK+Jw=
Message-ID: <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
Date: Tue, 12 Sep 2006 13:10:24 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [linux-pm] cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Cc: "Mark Gross" <mgross@linux.intel.com>,
       "Preece Scott-PREECE" <scott.preece@motorola.com>,
       "pm list" <linux-pm@lists.osdl.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060912083328.GA19197@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	 <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912083328.GA19197@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On 9/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> Can we at least try adding that, before deciding cpufreq is unsuitable
> and starting new interface? I do not think issues are nearly as big as
> you think.. (at user<->kernel interface level, anyway; you'll need big
> changes under the hood).

who talks about user <-> kernel interface level changes at the moment?!

Vitaly
