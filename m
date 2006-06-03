Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWFCNge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWFCNge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 09:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWFCNge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 09:36:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:26043 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751470AbWFCNge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 09:36:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GW/Ax/HGCeYj2bkg6JND7C891AVtKAPVEZqHRmWtx8uni55gsOf6FacbXc8dwNhPXSYcJ4YOB2oydpCuskQNObGiTGz6fjywkCxHzzo+v0btzmD4kfE7pHy2oJQdrqFNtOIk3IyW7APcc6uwLhm2QjvRRtX4uV1i0YNyx95yAh4=
Message-ID: <4d8e3fd30606030636m44e3ce28k9d0fb6938947d4b2@mail.gmail.com>
Date: Sat, 3 Jun 2006 15:36:22 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel development
Cc: "Kalin KOZHUHAROV" <kalin@thinrope.net>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <greg@kroah.com> wrote:
[...]
> >       http://linux.tar.bz/articles/2.6-development_process
>
> Ah, a very nice summary.
>
> Paolo, can I use this document as a base for this section in the HOWTO
> file (with proper attribution of course.)
>

That article is now living in a git tree, it now contains only spell
checks but I plan to work more on it in the next few days.

The follwoing is the git URI:
git://git.infradead.org/users/paolo/LinuxKernelDevelopmentProcess.git

gitweb interface here:
http://git.infradead.org/?p=users/paolo/LinuxKernelDevelopmentProcess.git;a=summary

Patched and comments are more then welcome ;-)

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
