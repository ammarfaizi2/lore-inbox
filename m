Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVLDLhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVLDLhj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 06:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVLDLhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 06:37:39 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:54969 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751015AbVLDLhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 06:37:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=SIzUKTNvsa8IFs0wxS39jRo/85iqUlJMyPsSKy+ZvzKMiTInhpIABqdookBkrgAw4iGZTOOB9B36/ga+1OMgepN27X4FEGZWszP3bdy9xptHrb6Kk6dIBu5cRRLHlFpWp9+qsvyLR0h3sNH29WXRtXLUKCcR+pZP69k9G8GpuVI=
Message-ID: <4392D4FD.3070402@gmail.com>
Date: Sun, 04 Dec 2005 12:37:33 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jmerkey@wolfmountaingroup.com
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> These folks have nothing new to innovate here. The memory manager and VM 
> gets revamped every other release. Exports get broken, binary only 
> module compatibility busted every rev of the kernel. I spend weeks on 
> each kernel fixing the breakage. These people don't get it, don't care, 
> and to be honest, you are wasting your time here trying to convince 
> them. It's never stable because they don't want it to be. This is how 
> they maintain control
> of this code. I have apps written for Windows in 1990 and 1998 that 
> still run on Windows XP today. Linux has no such concept of
> backwards compatiblity. Every company who has embraced it outside of 
> hardware based solutions is dying or has died. IBM is secretly
> forking it as we speak and using it to get out of paying for Unix licenses.
> As annoying as it is, accept it and live with it. These people have no 
> sense of loyalty to you or your customers. They don't even care about 
> each other.

Linux is _only_ a kernel, not a complete OS. And in a very big development
process [1].

If you want a complete OS get Fedora, openSUSE, Debian, etc. And if you need
longer life time, support, certifications get SLES or RHEL.


Btw, latest Coverity reports [2] shows things are getting better and the
main root of bugs are _drivers_ (53%), and far away filesystems(18%) and
inside net(15%).


[1] http://www.zip.com.au/~akpm/x.jpg
[2] http://www.coverity.com/forms/register.php?continue[]=open_source
-- 
Romanes eunt domus
