Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJ1FzU>; Mon, 28 Oct 2002 00:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJ1FzU>; Mon, 28 Oct 2002 00:55:20 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:55756 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262884AbSJ1FzT> convert rfc822-to-8bit; Mon, 28 Oct 2002 00:55:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Yiannis Koukouras" <tweetys@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: Load balancing module
Date: Sun, 27 Oct 2002 20:01:36 -0500
User-Agent: KMail/1.4.3
References: <20021027201323.8471.qmail@linuxmail.org>
In-Reply-To: <20021027201323.8471.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271901.37176.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 14:13, Yiannis Koukouras wrote:
> I am up to implement a module that will make "load balancing" on two
> ethernet interfaces connecting to the internet the same machine and
> hopefully propose it to get into the experimental kernel tree. Anyone
> interested? I could use any help. Plz cc to my email address.

You mean like the bonding driver (CONFIG_BONDING) that's already in the tree?

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
