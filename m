Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWFVUWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWFVUWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWFVUWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:22:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19922 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030393AbWFVUWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:22:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LBQ5TgFQI5vSZ1YDiF12+GTJr6O+q045UKgInWumRjY+g6VxEPMLY2fr/w5LMqkceD9yygYXhdEWACMcIrKl2c0v17cei+blzFGR8mExS/kryz67chctiKvGCcueVfrpzPG57JMYUz1sDj1BgvBImjd9oqB56cJ2BHJW7vbxMzk=
Message-ID: <4d8e3fd30606221321u4e27cf56le3bf60e07a8c4527@mail.gmail.com>
Date: Thu, 22 Jun 2006 22:21:59 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/06, Junio C Hamano <junkio@cox.net> wrote:
> I've merged quite a bit of stuff and tagged the tip of "master"
> as GIT 1.4.1-rc1.


Pulled and installed.

When I fire up gitk I see the following error messages, even if gitk
seems to be working fine:
paolo@Italia:~/git$ gitk
invalid command name ".ctop.cdet.left.ctext"
    while executing
"$ctext conf -state normal"
    (procedure "dispneartags" line 7)
    invoked from within
"dispneartags"
    (procedure "restartatags" line 28)
    invoked from within
"restartatags 869"
    ("after" script)


-- 
Paolo
http://paolociarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi
