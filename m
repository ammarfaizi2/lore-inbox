Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWGUR72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWGUR72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWGUR72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 13:59:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:26474 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750945AbWGUR71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 13:59:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jibGbCoAEGChvOn+zXsCTDmOl1poIMa8hiC+1vtblMnNGkieuEsg3FNVSll5A9ato+5+bIQdPoBiOE/nc+UxvV+I6QhO6EA13jIOYQqBTp0A9jXgdlzh4f6YHCEaMkV3mRS8JykzufUkciwJJnjoWvvFU/JW5nFArsJNBUkL/X0=
Message-ID: <d120d5000607211059x267a543cp1fddada9070a8380@mail.gmail.com>
Date: Fri, 21 Jul 2006 13:59:25 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44C10C08.5040007@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BFD911.70106@cmu.edu>
	 <d120d5000607201246s6af0223o83be95ef54147f10@mail.gmail.com>
	 <44C0EA85.30500@cmu.edu> <200607211300.17660.dtor@insightbb.com>
	 <44C10C08.5040007@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, George Nychis <gnychis@cmu.edu> wrote:
>
> The unmodified patch worked like a charm, thanks so much for your time.
> work, and help Dmitry
>

Thank you for testing, I will queue it for the mainline.

-- 
Dmitry
