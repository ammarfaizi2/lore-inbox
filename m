Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWEQROT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEQROT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWEQROT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:14:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:18227 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750716AbWEQROS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:14:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JLy0Gm0UlLufB5BiLRs0TvF9tCZ03ByDLuMykcGUvg6qZLrE4rnXUnnw7sX+xEaEQm8U0PYwdkid8hlOCB0Gh2XayRhq4jfR6gErpftYju6TzdQuXpWN6T7QHiQ8v4kFw4AAYpHcDZn0FXZsrrRR8Xxdo1WQGUVxSzM+fI7YXF8=
Message-ID: <6f6293f10605171014i59bdd7aahecbed6d9846e6185@mail.gmail.com>
Date: Wed, 17 May 2006 19:14:16 +0200
From: "Felipe Alfaro Solana" <felipe.alfaro@gmail.com>
To: "=?ISO-8859-1?Q?D=F6hr,_Markus_ICC-H?=" 
	<Markus.Doehr@siegenia-aubi.com>
Subject: Re: replacing X Window System !
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA67660181D2AB@mxnd200-9.si-aubi.siegenia-aubi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <FC7F4950D2B3B845901C3CE3A1CA67660181D2AB@mxnd200-9.si-aubi.siegenia-aubi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RDP is more like VNC, AFAIK.  It serves a different purpose.
>
> No, not necessarily. It´s very possible to run only a single application
> from an RDP serving system (as you do with X), the application gets executed
> on the server and the display is pushed to the client.

AFAIK, only ICA allows running single applications (publishing), not
RDP. And, BTW, they _do_ consume a complete user session, so they're
pretty a resource hog.
