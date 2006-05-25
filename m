Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWEYXGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWEYXGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWEYXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:06:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:43874 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030201AbWEYXGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:06:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NfGiYNUd6LdveUfUnG1NkJEtFkUY2edDUxWdGevb08olOdg9/toZOJPVqW/rRUEuMjLOVsAaAfNZbF8Ukn7tKTzVKY5omgV6cxRk3ywerXNe5IpmHGoO8/2iLdZKnxqUQYiiGuW7YrIUCEhORWDUWhh57nLfbVjUCrXRoHcKMvg=
Message-ID: <9a8748490605251606q256d7e67s8b8220eae05a5422@mail.gmail.com>
Date: Fri, 26 May 2006 01:06:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "4Front Technologies" <dev@opensound.com>
Subject: Re: How to check if kernel sources are installed on a system?
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4476321A.8090508@opensound.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <4476321A.8090508@opensound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/06, 4Front Technologies <dev@opensound.com> wrote:
>
> Anything to get out-of-kernel modules compiling without jumping through 1000
> hoops is good.
>

hmm, I'd say that anything that encourages people to merge their code
with mainline instead of maintaining out-of-tree modules is good.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
