Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWEZAJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWEZAJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWEZAJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:09:38 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:22703 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S1030207AbWEZAJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:09:37 -0400
Message-ID: <44764748.7070102@mandriva.org>
Date: Fri, 26 May 2006 03:09:44 +0300
From: Thomas Backlund <tmb@mandriva.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com> <9a8748490605251551r4fa54084gc585e79f34dc1554@mail.gmail.com>
In-Reply-To: <9a8748490605251551r4fa54084gc585e79f34dc1554@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> 
> Finding a way to detect if people have kernel sources available that
> are configured to match the current running kernel that'll work for
> everyone is a lost cause - give it up.
> Looking in  /lib/modules/$(uname -r)/build/  and/or
> /lib/modules/$(uname -r)/source/ is probably the best you can do (and
> doing that makes sense - at least to me)...
> 
> 

Yeah,
I alway thought that this was the correct way...

And theese links are also found on Mandriva...

Not to mention Ati & nVidia installers that also check for theese links...

--
Regards

Thomas
