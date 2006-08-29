Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWH2QQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWH2QQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWH2QQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:16:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20187 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965051AbWH2QQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:16:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XY0Ak3MuuHS1M2KkFCaLVb+SjsvtXjxKuspqK13/XiaKt3n1XA2g0M3Xiq1riTU3unG47B7e55P36mAsHTCwJaQq/ys2U1ChKtU79pCoKRrQtHKUk7lRNdp+9OBpCm+TphnEq0dGhBVlEO1ciY3WiMZg/rBUiXD3Pj7mmt+2d5Q=
Message-ID: <a2ebde260608290916o696bf5d6odbca254af079f2a8@mail.gmail.com>
Date: Wed, 30 Aug 2006 00:16:27 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Andi Kleen" <ak@suse.de>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608290908500.18149@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
	 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
	 <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
	 <Pine.LNX.4.64.0608290908500.18149@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, please do not get me wrong. Or perhaps please tolerate my poor English.

My intention is just trying to understand whether there is an absolute
rationality for a design choice or it just has to have a choice and
the choice can be made arbitrarily.

Sorry again if my English cause any misunderstanding.


2006/8/30, Christoph Lameter <clameter@sgi.com>:
> On Wed, 30 Aug 2006, Dong Feng wrote:
>
> > Or perhaps this offset is just some personal favor. Say if the first
> > kernel designer decided to locate kernel at 2-3G linear address, then
> > 2G offset would have appeared in code. Is this the case?
>
> Well this is the second time that you suggest that the reason for
> technical decisions have to do with personal favors. Are you trying to
> provoke us into answering your question?
>
>
