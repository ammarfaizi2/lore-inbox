Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWGERDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWGERDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWGERDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:03:15 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:63584 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964798AbWGERDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:03:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=loM37pOccTKb9A1fzT7AXnWJTq3+p6cbBIS+B6MuThwC+WimbZzeHqbEoJycoXO0zU668InBPYgFzGkS5f1Xz4+ajDsR57q82ncpvefvRiAKAFWmWpnJAdDaMIS6gagQaZ+am8o6uLSOpAAJKleAGQOqZcESEAg0JzUEBG3VBB0=
Message-ID: <e1e1d5f40607051003v6b644e82p346c6e0661f39274@mail.gmail.com>
Date: Wed, 5 Jul 2006 13:03:14 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Andreas Gruenbacher" <agruen@suse.de>
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607051859.41638.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607051859.41638.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a " You are not authorized to access bug #190296. To see this bug,
you must first log in to an account with the appropriate permissions."
on the referred bugzilla page.

What kind of symbol uses more than 127 characters, anyways ?

Daniel


-- 
What this world needs is a good five-dollar plasma weapon.
