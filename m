Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWCCL6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWCCL6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWCCL6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:58:51 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:38596 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWCCL6v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:58:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kQBS2ZzI5T3lAuV9XFn2zmfNFoG626BsTkMlIKvVgE2jdV/RnGoaAQiGhLbuM04e/BWGktpdU4DZnySMXYKPlko8PdYQsMsXNnIxIVdj4sfO9kydzP806IvoVVbU7H37cCoHX0LKZ/SOJBbG2kkOTW6xkxIs+/c11B7HT3CSRbA=
Message-ID: <503e0f9d0603030358l524179cfs77c9863c96750346@mail.gmail.com>
Date: Fri, 3 Mar 2006 17:28:50 +0530
From: "tim tim" <tictactoe.tim@gmail.com>
To: "Andrew Haninger" <ahaning@gmail.com>
Subject: Re: module-init-tools invain
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <105c793f0603030343n37be276dp73c2603cf1ed18fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603030003i566d29ecj3c476d245a42f17a@mail.gmail.com>
	 <105c793f0603030343n37be276dp73c2603cf1ed18fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i don't think modutil-init-tools was installed previously on my
system.. since i tried to rpm -qa moduleinit .. alll
i can uninstall if it is a rpm .. (rpm -e).. but how can i uninstall
this tolls..

On 3/3/06, Andrew Haninger <ahaning@gmail.com> wrote:
> On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> > i downloaded the tool and installed as was given in the readme file..
> > then i followed my procedure of kernel installation.. now also.. i get
> > same depmod.. problemm..
> Perhaps you need to uninstall your old modutils installation? I know
> that modutils and module-init-tools can exist on the same machine, but
> it might be easier and clearer to know which one is causing problems
> if you have just one installed.
>
> > but when i run the command
> > depmod 2.6.10 from that kernel directory it says nothing.. not even
> > error .. what can i do..
> I've always used depmod -a.
>
> But again, be sure you're using the module-init-tools version of
> depmod and not your old modutils copy.
>
> -Andy
>


--
--->> Experience is the wise man's toll  <<----
