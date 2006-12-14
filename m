Return-Path: <linux-kernel-owner+w=401wt.eu-S1752018AbWLNXyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWLNXyU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWLNXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:54:20 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:50238 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbWLNXyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:54:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0yvGAzcIvJUuUSlN3MlJdfhNSB1QrYaoBV80woR9qwF67ZHEpfyN3v2JRLTbeYcp2ILIWTYWi0148VaUnwvKsvIfKF5mSmJqEHQ2J6U1wCTRYDFvac5LUGu6JHK+gRZbcW1m3ZRNDZirb9WXshXiWxFRmPhLHiYKA/uOMkM2R4=
Message-ID: <7b69d1470612141554n45070e37wc8ecc019b34a5bb@mail.gmail.com>
Date: Thu, 14 Dec 2006 17:54:17 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH/RFC] CodingStyle updates
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
In-Reply-To: <4581E192.3010108@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
	 <7b69d1470612141533v6ea076ap7149dbabceeb8ab4@mail.gmail.com>
	 <4581E192.3010108@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> Scott Preece wrote:
> [1]
> >>  Outside of comments, documentation and except in Kconfig, spaces are
> >> never
> >>  used for indentation, and the above example is deliberately broken.
> > ---
> >
> > I realize it isn't text you added, but what's that supposed to mean?
> > Surely the 8-character indents are made up of spaces.  Does it mean
>
> No, the 8-character indents are made of one ASCII TAB character.
----

Probably should say so, then. As it is, the only way to figure that
out (other than loking at code (:)) is to infer it from the .emacs
example, which doesn't come until 8 chapters later in the document.

Maybe:

Outside of comments, documentation, and Kconfig, use TAB characters
for indentation. Spaces are never used for indentation, and the above
example is deliberately broken in several ways, including use of
spaces.

scott
