Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbRJPQaN>; Tue, 16 Oct 2001 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJPQaD>; Tue, 16 Oct 2001 12:30:03 -0400
Received: from zen.via.ecp.fr ([138.195.130.71]:38888 "HELO zen.via.ecp.fr")
	by vger.kernel.org with SMTP id <S276470AbRJPQ34>;
	Tue, 16 Oct 2001 12:29:56 -0400
Date: Tue, 16 Oct 2001 18:30:27 +0200
From: =?iso-8859-1?Q?St=E9phane_Borel?= <stef@via.ecp.fr>
To: linux-kernel@vger.kernel.org
Subject: bug in DVD ioctls in 2.4.12 ?
Message-ID: <20011016183027.A7173@via.ecp.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

playing with DVD ioctls with kernel 2.4.12 shows a long delay, that
didn't exist with 2.4.9, before some calls like Authentication Success
Flag.

This sounds like a bug to me, but maybe something has changed ?

-- 
Stef
