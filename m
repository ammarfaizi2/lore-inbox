Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWG3E1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWG3E1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 00:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWG3E1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 00:27:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:37483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWG3E1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 00:27:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NpV0Gpi8qzCbwn46bRTto5dhlpVr9HikbbgE20ebQtZLP7+UlzXph/yhWJrg4LLm5qgxFTzi1GvErAyKYIipoErdahRDLLl6cC97znioXXrYBOLfC9ErpPD/nMyMuUmU4Pk5uDWTzW12TPZv2S9SEAj/SjC6C2NT4S0f6UDdRCY=
Message-ID: <9a8748490607292127ncea6bcep89f9841a09411b3@mail.gmail.com>
Date: Sun, 30 Jul 2006 06:27:52 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: V2.6.18-rc2-latest git compilation fails on i386
Cc: linux-kernel@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>
In-Reply-To: <44CC18B2.4040309@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44CC18B2.4040309@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> When compiling the latest i386 kernel from Linus's tree with CONFIG_STACK_UNWIND
> defined, the following compilation error occurs:
>
I reported that problem yesterday and Alexey Dobriyan provided a fix :
http://lkml.org/lkml/2006/7/29/85

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
