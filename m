Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWADR3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWADR3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWADR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:29:52 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:58065 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965229AbWADR3v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:29:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sYMNnUVaxH5c5g1tnkRPz1t5ciqS9sHZ0ZAO7QKus7ZUTX3u+V5BWRZsfPUMrf3ZpYSq3CdY9ccc3+6teRTuBp8VfedSGcBk9NUZObf3uNKnO0gQeeqRakqfUY3dpw5XsngtQnqie9+a6eb8ygZZMwhMcol9oaw5AO1a+RutWeE=
Message-ID: <b6c5339f0601040929jcbf2aadheec806fb453e58dd@mail.gmail.com>
Date: Wed, 4 Jan 2006 12:29:50 -0500
From: Bob Copeland <email@bobcopeland.com>
To: x-lists@cqsat.com
Subject: Re: kernel programming donts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY7-F20B9964B2E040C06705307C52F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY7-F20B9964B2E040C06705307C52F0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, J R <x-list-subscriptions@hotmail.com> wrote:
>
> Is there a list of kernel / driver development "donts" documented in 1
> place. I'm looking for examples of coding errors that would lead to
> leaks,  crashes or vulnerabilities - like using tainted data from
> copy_from_user() in an unsafe way. Have these things been collected in 1
> place?

There are some documents on kerneljanitors.org, for example:

http://kerneljanitors.org/drivers-dosdonts/index.html
