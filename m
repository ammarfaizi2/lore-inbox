Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWFJWhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWFJWhH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWFJWhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:37:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:3131 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWFJWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:37:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pFXjq/YuvjgSA0tvoHQkzZGNi+YXt3sNZtare3pqX7Cpy8pW4dOE46jreF+htLgQkT2LW0d/zG/Mw8q+zFVCZlklAfacelSNJQtRT6NL1xZe4ZHOJOJgSoktsaSZE5eX2Qe4fU8K0IhlAsHnBuj6RovkNiYVHC98fgwnaDjTLcg=
Message-ID: <4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
Date: Sun, 11 Jun 2006 00:37:04 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.4.0
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> The latest feature release GIT 1.4.0 is available at the
> usual places:
>
>         http://www.kernel.org/pub/software/scm/git/

Cannot pull:

paolo@Italia:~/git$ git pull
error: no such remote ref refs/heads/jc/bind
Fetch failure: git://www.kernel.org/pub/scm/git/git.git

Am I alone?

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
