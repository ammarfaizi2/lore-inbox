Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbQLSJeJ>; Tue, 19 Dec 2000 04:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLSJd6>; Tue, 19 Dec 2000 04:33:58 -0500
Received: from hermes.mixx.net ([212.84.196.2]:20751 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129588AbQLSJdm>;
	Tue, 19 Dec 2000 04:33:42 -0500
Message-ID: <3A3F23D8.406F5444@innominate.de>
Date: Tue, 19 Dec 2000 10:01:13 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <0012171922570J.00623@gimli>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> The idea of using semaphores to regulate the cycling of a daemon was
> suggested to me by Arjan Vos.

Actually, his name is Arjan van de Ven - sorry Arjan :-o

Thanks also to Phillip Rumpf for auditing this patch for cross-platform
correctness.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
