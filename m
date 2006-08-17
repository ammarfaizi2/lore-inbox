Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWHQLDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWHQLDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWHQLDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:03:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:41096 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964797AbWHQLDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:03:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i74m2tVzRCSgEZ2/wFOhHCbljwda9UuR1eqstMYxzmI0z+VMRlv16ME8KXwtJYRFGcubowFuvkaRJ8Npyav8XvVAVRCHZEktDtG0Kb1uzv7OlGTaLUWvmyC29Jh5oPkEDLqlVuOW3VPPb+/V2pdlC5qIhvO4dzSpQknpqbae+9k=
Message-ID: <9a8748490608170403q43a26768y7f789b2b67d10409@mail.gmail.com>
Date: Thu, 17 Aug 2006 13:03:39 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Markus Dahms" <dahms@fh-brandenburg.de>
Subject: Re: [PATCH][RFC][RESEND] remove broken URLs from net drivers' output
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060817093053.GA13992@fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060817093053.GA13992@fh-brandenburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Markus Dahms <dahms@fh-brandenburg.de> wrote:
> Remove broken URLs (www.scyld.com) from network drivers' logging output.
> URLs in comments and other strings are left intact.
>
Makes good sense to me.
No point in refering to URLs that are no longer operational.
The best thing would be to find a replacement URL if one exist, but
failing that removing the wrong ones is a good thing IMHO.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
