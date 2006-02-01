Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWBAMjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWBAMjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWBAMiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:38:52 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:22077 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161043AbWBAMit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:38:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cmTEafXJYby9cLurCn9hFgtfTCpFpjLnNe/0XT0VcaLCeNdci5gtHJrn2gq+Lz8sVoEcAf21TmqeDYVU1UBTAwx3+8QCNSqv0aBGSgkn/YcXzRcwx6PjJkcr+DW7HxFo5aDfm0eTmT/+N+GqiJ1SCs2yXKThagYtJ7loO00FhVA=
Message-ID: <84144f020602010438n3a1b50b3r3d2db9c84da94166@mail.gmail.com>
Date: Wed, 1 Feb 2006 14:38:48 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> The name is currently mostly historical, from the time when these components
> could be built as kernel modules.

I think suspend_plugin would be a nicer name. Your code is even using
the term 'plugin' and 'filter' instead of module in many places.

                            Pekka
